﻿using System;
using System.IO;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Logging;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata;
using common.dao;

namespace web
{
    public class Startup
    {
        public Startup(IHostingEnvironment env)
        {
            var builder = new ConfigurationBuilder()
                .SetBasePath(env.ContentRootPath)
                .AddJsonFile("appsettings-web.json", optional: false, reloadOnChange: true)
                .AddJsonFile($"appsettings-web.{env.EnvironmentName}.json", optional: true)
                .AddEnvironmentVariables();

            if (env.IsDevelopment())
            {
                builder
                .AddJsonFile(Path.GetFullPath(@"../common/appsettings-common.json"), optional: false, reloadOnChange: true)
                .AddJsonFile(Path.GetFullPath($"../common/appsettings-common.{env.EnvironmentName}.json"), optional: true);
            }
            else
            {
                builder
                .AddJsonFile("appsettings-common.json", optional: false, reloadOnChange: true)
                .AddJsonFile($"appsettings-common.{env.EnvironmentName}.json", optional: true);
            }
            Configuration = builder.Build();
        }

        public IConfigurationRoot Configuration { get; }

        // This method gets called by the runtime. Use this method to add services to the container.
        public void ConfigureServices(IServiceCollection services)
        {
            services.AddDbContext<wakatime_consoleContext>(options => options.UseNpgsql(Configuration.GetConnectionString("docker")));
            services.AddMvc();
        }

        // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
        public void Configure(IApplicationBuilder app, IHostingEnvironment env, ILoggerFactory loggerFactory)
        {
            loggerFactory.AddConsole(Configuration.GetSection("Logging"));
            loggerFactory.AddDebug();

            app.UseMvc();
        }
    }
}
