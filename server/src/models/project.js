'use strict';
module.exports = function(sequelize, DataTypes) {
  var Project = sequelize.define('Project', {
      date: {
        allowNull: false,
        type: DataTypes.DATE
      },
      name: {
        allowNull: false,
        type: DataTypes.STRING
      },
      totalSeconds: {
        allowNull: false,
        type: DataTypes.INTEGER
      },
  }, {
    classMethods: {
      associate: function(models) {
          models.Project.hasMany(models.Editor, { foreignKey: 'projectId', sourceKey: 'id', as: 'editors' });
          models.Project.hasMany(models.Entity, { foreignKey: 'projectId', sourceKey: 'id' });
          models.Project.hasMany(models.Language, { foreignKey: 'projectId', sourceKey: 'id' });
          models.Project.hasMany(models.OperatingSystems, { foreignKey: 'projectId', sourceKey: 'id' });
      }
    }
  });
  return Project;
};