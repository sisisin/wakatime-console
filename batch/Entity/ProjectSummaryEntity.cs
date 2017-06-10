using System;
using System.Collections.Generic;
using System.Runtime.Serialization;

namespace batch.Entity
{
#pragma warning disable 0649

	[DataContract]
    public class ProjectSummaryEntity
    {
		[DataMember]
		internal List<ProjectSummaryDataEntity> data;

		[DataMember]
		internal string start;

		[DataMember]
		internal string end;
	}

    [DataContract]
    public class ProjectSummaryDataEntity
    {
        [DataMember]
        internal GrandTotal grand_total;

        [DataMember]
        internal List<Language> languages;

        [DataMember]
        internal List<Editor> editors;

		[DataMember]
        internal List<Entity> entities;
		
        [DataMember]
        internal List<OperatingSystem> operating_systems;

    }
#pragma warning restore 0649
}
