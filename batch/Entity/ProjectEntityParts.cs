using System;
using System.Collections.Generic;
using System.Runtime.Serialization;

namespace batch.Entity
{
#pragma warning disable 0649
	[DataContract]
	public class GrandTotal
	{
		[DataMember]
		internal int total_seconds;
	}

	[DataContract]
	public class Language : SummaryDataEntityBase { }
	[DataContract]
	public class Editor : SummaryDataEntityBase { }
	[DataContract]
	public class OperatingSystem : SummaryDataEntityBase { }
	[DataContract]
	public class Entity : SummaryDataEntityBase { }
	[DataContract]
	public class Project : SummaryDataEntityBase { }

	[DataContract]
	public class SummaryDataEntityBase
	{
		[DataMember]
		internal string name;

		[DataMember]
		internal int total_seconds;
	}
#pragma warning restore 0649
}
