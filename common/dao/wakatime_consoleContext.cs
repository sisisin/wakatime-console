using System;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata;

namespace common.dao
{
    public partial class wakatime_consoleContext : DbContext
    {
        public virtual DbSet<Editors> Editors { get; set; }
        public virtual DbSet<Entities> Entities { get; set; }
        public virtual DbSet<Languages> Languages { get; set; }
        public virtual DbSet<OperatingSystems> OperatingSystems { get; set; }
        public virtual DbSet<Projects> Projects { get; set; }

        public wakatime_consoleContext(DbContextOptions<wakatime_consoleContext> options) : base(options)
        {
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Editors>(entity =>
            {
                entity.ToTable("editors");

                entity.HasIndex(e => e.ProjectId)
                    .HasName("index_editors_on_project_id");

                entity.Property(e => e.Id).HasColumnName("id");

                entity.Property(e => e.CreatedAt).HasColumnName("created_at");

                entity.Property(e => e.Name)
                    .IsRequired()
                    .HasColumnName("name")
                    .HasColumnType("varchar");

                entity.Property(e => e.ProjectId).HasColumnName("project_id");

                entity.Property(e => e.TotalSeconds).HasColumnName("total_seconds");

                entity.Property(e => e.UpdatedAt).HasColumnName("updated_at");

                entity.HasOne(d => d.Project)
                    .WithMany(p => p.Editors)
                    .HasForeignKey(d => d.ProjectId)
                    .OnDelete(DeleteBehavior.Restrict)
                    .HasConstraintName("fk_rails_476a5ae1c7");
            });

            modelBuilder.Entity<Entities>(entity =>
            {
                entity.ToTable("entities");

                entity.HasIndex(e => e.ProjectId)
                    .HasName("index_entities_on_project_id");

                entity.Property(e => e.Id).HasColumnName("id");

                entity.Property(e => e.CreatedAt).HasColumnName("created_at");

                entity.Property(e => e.Name)
                    .IsRequired()
                    .HasColumnName("name")
                    .HasColumnType("varchar");

                entity.Property(e => e.ProjectId).HasColumnName("project_id");

                entity.Property(e => e.TotalSeconds).HasColumnName("total_seconds");

                entity.Property(e => e.UpdatedAt).HasColumnName("updated_at");

                entity.HasOne(d => d.Project)
                    .WithMany(p => p.Entities)
                    .HasForeignKey(d => d.ProjectId)
                    .OnDelete(DeleteBehavior.Restrict)
                    .HasConstraintName("fk_rails_a0c7fbec47");
            });

            modelBuilder.Entity<Languages>(entity =>
            {
                entity.ToTable("languages");

                entity.HasIndex(e => e.ProjectId)
                    .HasName("index_languages_on_project_id");

                entity.Property(e => e.Id).HasColumnName("id");

                entity.Property(e => e.CreatedAt).HasColumnName("created_at");

                entity.Property(e => e.Name)
                    .IsRequired()
                    .HasColumnName("name")
                    .HasColumnType("varchar");

                entity.Property(e => e.ProjectId).HasColumnName("project_id");

                entity.Property(e => e.TotalSeconds).HasColumnName("total_seconds");

                entity.Property(e => e.UpdatedAt).HasColumnName("updated_at");

                entity.HasOne(d => d.Project)
                    .WithMany(p => p.Languages)
                    .HasForeignKey(d => d.ProjectId)
                    .OnDelete(DeleteBehavior.Restrict)
                    .HasConstraintName("fk_rails_a44d178db8");
            });

            modelBuilder.Entity<OperatingSystems>(entity =>
            {
                entity.ToTable("operating_systems");

                entity.HasIndex(e => e.ProjectId)
                    .HasName("index_operating_systems_on_project_id");

                entity.Property(e => e.Id).HasColumnName("id");

                entity.Property(e => e.CreatedAt).HasColumnName("created_at");

                entity.Property(e => e.Name)
                    .IsRequired()
                    .HasColumnName("name")
                    .HasColumnType("varchar");

                entity.Property(e => e.ProjectId).HasColumnName("project_id");

                entity.Property(e => e.TotalSeconds).HasColumnName("total_seconds");

                entity.Property(e => e.UpdatedAt).HasColumnName("updated_at");

                entity.HasOne(d => d.Project)
                    .WithMany(p => p.OperatingSystems)
                    .HasForeignKey(d => d.ProjectId)
                    .OnDelete(DeleteBehavior.Restrict)
                    .HasConstraintName("fk_rails_540a0b288f");
            });

            modelBuilder.Entity<Projects>(entity =>
            {
                entity.ToTable("projects");

                entity.HasIndex(e => new { e.Date, e.Name })
                    .HasName("index_projects_on_date_and_name")
                    .IsUnique();

                entity.Property(e => e.Id).HasColumnName("id");

                entity.Property(e => e.CreatedAt).HasColumnName("created_at");

                entity.Property(e => e.Date)
                    .HasColumnName("date")
                    .HasColumnType("date");

                entity.Property(e => e.Name)
                    .IsRequired()
                    .HasColumnName("name")
                    .HasColumnType("varchar");

                entity.Property(e => e.TotalSeconds).HasColumnName("total_seconds");

                entity.Property(e => e.UpdatedAt).HasColumnName("updated_at");
            });
        }
    }
}