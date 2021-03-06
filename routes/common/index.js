const router      = require('express').Router();
const adminAuth   = require('../../src/authentication/admin');
const basicAuth   = require('../../src/authentication/basic');

const menu        = require('./menu');
const leaderboard = require('./leaderboard');
const toppings    = require('./toppings');
const fillings    = require('./fillings');
const services    = require('./services');
const customs     = require('./customs');
const user        = require('./user');

router.get('/user/:userid',basicAuth,user.get);

router.get('/customs',basicAuth,customs.getCustoms);
router.get('/customs/:customid',basicAuth,customs.getCustom);
router.get('/customs/:customid/reviews',basicAuth,customs.getCustomReviews);

router.get('/menu',basicAuth,menu.getAll);
router.get('/toppings',basicAuth,toppings.getAll);
router.get('/fillings',basicAuth,fillings.getAll);
router.get('/services',basicAuth,services.getAll);
router.get('/leaderboard',basicAuth,leaderboard.get);

router.get('/menu/:item',basicAuth,menu.get);
router.get('/toppings/:name',basicAuth,toppings.get);
router.get('/fillings/:name',basicAuth,fillings.get);
router.get('/services/:name',basicAuth,services.get);

router.put('/menu',    adminAuth,menu.put);
router.put('/toppings',adminAuth,toppings.put);
router.put('/fillings',adminAuth,fillings.put);
router.put('/services',adminAuth,services.put);

router.patch('/menu/:item',    adminAuth,menu.patch);
router.patch('/toppings/:name',adminAuth,toppings.patch);
router.patch('/fillings/:name',adminAuth,fillings.patch);
router.patch('/services/:name',adminAuth,services.patch);


router.delete('/menu/:item',    adminAuth,menu.remove);
router.delete('/toppings/:name',adminAuth,toppings.remove);
router.delete('/fillings/:name',adminAuth,fillings.remove);
router.delete('/services/:name',adminAuth,services.remove);


module.exports = router;
