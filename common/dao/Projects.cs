using System;
using System.Collections.Generic;

namespace common.dao
{
    public partial class Projects
    {
        public Projects()
        {
            Editors = new HashSet<Editors>();
            Entities = new HashSet<Entities>();
            Languages = new HashSet<Languages>();
            OperatingSystems = new HashSet<OperatingSystems>();
        }

        public int Id { get; set; }
        public DateTime Date { get; set; }
        public string Name { get; set; }
        public int TotalSeconds { get; set; }
        public DateTime CreatedAt { get; set; }
        public DateTime UpdatedAt { get; set; }

        public virtual ICollection<Editors> Editors { get; set; }
        public virtual ICollection<Entities> Entities { get; set; }
        public virtual ICollection<Languages> Languages { get; set; }
        public virtual ICollection<OperatingSystems> OperatingSystems { get; set; }
    }
}
