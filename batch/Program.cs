﻿﻿using System;
using System.Linq;
using Microsoft.Extensions.Configuration;
using System.IO;
using System.Collections.Generic;
using common.dao;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata;

namespace batch
{
    class Program
    {
        public static IConfigurationRoot Configuration { get; set; }

        public static void ConfigureService(IServiceCollection services)
        {
            services.AddDbContext<wakatime_consoleContext>(options => options.UseNpgsql(Configuration.GetConnectionString("db")));
        }

        static void Main(string[] args)
        {
            var environmentName = Environment.GetEnvironmentVariable("ASPNETCORE_ENVIRONMENT");
            var builder = new ConfigurationBuilder()
                .SetBasePath(Path.GetFullPath("./"))
                .AddJsonFile("appsettings.json", optional: false, reloadOnChange: true)
                .AddJsonFile($"appsettings.{environmentName}.json", optional: true)
                .AddJsonFile(Path.GetFullPath(@"../common/appsettings.json"), optional: false, reloadOnChange: true)
                .AddJsonFile(Path.GetFullPath($"../common/appsettings.{environmentName}.json"), optional: true)
                .AddEnvironmentVariables();
            Configuration = builder.Build();

            var services = new ServiceCollection();
            ConfigureService(services);
            var serviceProvider = services.BuildServiceProvider();

            var targetDate = args.Length == 0 ? DateTime.Now.AddDays(-1) : DateTime.Parse(args[0]);

            var wktClient = new WakatimeClient(Configuration);
            var res = wktClient.FetchProjects(targetDate);
            res.Wait();

            using (var db = ActivatorUtilities.CreateInstance<wakatime_consoleContext>(serviceProvider))
            {
                var tasks = res.Result.data.FirstOrDefault().projects.Select(async proj =>
                {
                    var response = await wktClient.FetchProjectSummary(targetDate, proj.name);
                    var data = response.data.First();
                    var project = new Projects
                    {
                        Date = targetDate,
                        Name = proj.name,
                        TotalSeconds = data.grand_total.total_seconds
                    };
                    data.editors.ForEach(e => project.Editors.Add(new Editors { Name = e.name, TotalSeconds = e.total_seconds }));
                    data.entities.ForEach(e => project.Entities.Add(new Entities { Name = e.name, TotalSeconds = e.total_seconds }));
                    data.languages.ForEach(e => project.Languages.Add(new Languages { Name = e.name, TotalSeconds = e.total_seconds }));
                    data.operating_systems.ForEach(e => project.OperatingSystems.Add(new OperatingSystems { Name = e.name, TotalSeconds = e.total_seconds }));

                    db.Projects.Add(project);
                    db.SaveChanges();

                    return response;
                });
                foreach(var t in tasks) { t.Wait(); }
            }
        }
    }
}
