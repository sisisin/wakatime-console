﻿using System;
using System.Net.Http;
using Microsoft.Extensions.Configuration;
using Microsoft.AspNetCore.WebUtilities;
using System.Collections.Generic;
using System.Threading.Tasks;
using System.Runtime.Serialization.Json;
using System.Linq;
using batch.Entity;

namespace batch
{
    public class WakatimeClient
    {
        private static HttpClient client = new HttpClient();
        private string baseUrl = "https://wakatime.com/api/v1/users/52f058ec-e04e-436b-906d-eff6c461abf5/summaries";
        private IConfigurationRoot conf;
        public WakatimeClient(IConfigurationRoot conf)
        {
            this.conf = conf;
        }

        async public Task<ProjectEntity> FetchProjects(DateTime targetDate)
        {
            var q = new Dictionary<string, string>(){
                {"api_key", conf.GetValue<string>("WAKATIME_API_KEY")},
                {"start", targetDate.Date.ToString("yyyy/MM/dd")},
                {"end", targetDate.Date.ToString("yyyy/MM/dd")}
            };

            var result = await (await client.GetAsync(QueryHelpers.AddQueryString(baseUrl, q))).Content.ReadAsStreamAsync();
            var ser = new DataContractJsonSerializer(typeof(Entity.ProjectEntity));
            var projects = (Entity.ProjectEntity)ser.ReadObject(result);
            return projects;
        }

        async public Task<ProjectSummaryEntity> FetchProjectSummary(DateTime targetDate, string projectName)
        {
            var q = new Dictionary<string, string>(){
                {"api_key", conf.GetValue<string>("WAKATIME_API_KEY")},
                {"start", targetDate.Date.ToString("yyyy/MM/dd")},
                {"end", targetDate.Date.ToString("yyyy/MM/dd")},
                {"project", projectName}
            };

            var result = await (await client.GetAsync(QueryHelpers.AddQueryString(baseUrl, q))).Content.ReadAsStreamAsync();
            var ser = new DataContractJsonSerializer(typeof(ProjectSummaryEntity));
            var summary = (ProjectSummaryEntity)ser.ReadObject(result);
            return summary;
        }
    }
}
