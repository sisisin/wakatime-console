using System;
using System.Collections.Generic;

namespace common.dao
{
    public partial class Languages
    {
        public int Id { get; set; }
        public int ProjectId { get; set; }
        public string Name { get; set; }
        public int TotalSeconds { get; set; }
        public DateTime CreatedAt { get; set; }
        public DateTime UpdatedAt { get; set; }

        public virtual Projects Project { get; set; }
    }
}
