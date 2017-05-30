import Sequelize = require('sequelize');
export type IDbConnection = {
  sequelize: Sequelize.Sequelize;
  Sequelize: Sequelize.SequelizeStatic;
} & { [key: string]: Sequelize.Model<{} & Sequelize.Instance<{}>, {}>; };
