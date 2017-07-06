using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using common.dao;
using Microsoft.EntityFrameworkCore;

namespace web.Controllers
{
    [Route("api/[controller]")]
    public class SummariesController : Controller
    {
        private readonly wakatime_consoleContext ctx;
        public SummariesController(wakatime_consoleContext ctx) {
            this.ctx = ctx;
        }
        // GET api/values
        [HttpGet]
        public IEnumerable<Projects> Get()
        {
            return ctx.Projects
                .Include(p => p.Editors)
                .Include(p => p.Entities)
                .Include(p => p.Languages)
                .Include(p => p.OperatingSystems)
                .Where(p => p.Date >= DateTime.Now.AddMonths(-1))
                .ToList();
        }

        // GET api/values/5
        [HttpGet("{id}")]
        public Projects Get(int id)
        {
            return ctx.Projects.Where(p => p.Id == id).FirstOrDefault();
        }
    }
}
