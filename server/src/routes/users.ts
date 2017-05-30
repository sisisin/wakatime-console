import express = require('express');
const router = express.Router();
import { IDbConnection } from '../typings/interface';
const db: IDbConnection = require('../models');

/* GET users listing. */
router.get('/', async function (req, res, next) {
  const p = await db.Project.findAll().then(d => d.map(row => {
    return row.toJSON();
  }));
  console.log(p);
  res.send('respond with a resource');
});

module.exports = router;
