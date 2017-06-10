using System;
using System.Runtime.Serialization;
using System.Collections.Generic;

namespace batch.Entity
{
#pragma warning disable 0649

    [DataContract]
    public class ProjectEntity
    {
        [DataMember]
        internal List<ProjectNameDataEntity> data;

        [DataMember]
        internal string start;

        [DataMember]
        internal string end;
    }

    [DataContract]
    public class ProjectNameDataEntity
    {
        [DataMember]
        internal List<Project> projects;
    }

#pragma warning restore 0649
}
