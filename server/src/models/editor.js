'use strict';
module.exports = function(sequelize, DataTypes) {
  var Editor = sequelize.define('Editor', {
      projectId: {
        allowNull: false,
        type: DataTypes.INTEGER
      },
      name: {
        allowNull: false,
        type: DataTypes.STRING
      },
      totalSeconds: {
        allowNull: false,
        type: DataTypes.INTEGER
      }
  }, {
    classMethods: {
      associate: function(models) {
      }
    }
  });
  return Editor;
};