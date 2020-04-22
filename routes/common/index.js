const router = require('express').Router();
const adminAuth   = require('../../src/authentication/admin');

const menu        = require('./menu');
const leaderboard = require('./leaderboard');
const toppings    = require('./toppings');
const fillings    = require('./fillings');
const services    = require('./services');
const reviews     = require('./reviews');

// Menu handlers (need to add some filters for this section)
router.get('/menu/:item', menu.get);
router.get('/menu',menu.getAll);
router.put('/menu',adminAuth,menu.put);
router.delete('/menu/:item',adminAuth,menu.remove);
router.patch('/menu/:item',adminAuth,menu.patch);

// Toppings' handlers (need to add price filters for this section)
router.get('/toppings/:name', toppings.get);
router.get('/toppings', toppings.getAll);
router.put('/toppings',adminAuth,toppings.put);
router.patch('/toppings/:name',adminAuth,toppings.patch);
router.delete('/toppings/:name',adminAuth,toppings.remove);


// Fillings' handlers (need to add price filters for this section)
router.get('/fillings', fillings.getAll);
router.get('/fillings/:name', fillings.get);
router.put('/fillings',adminAuth,fillings.put);
router.patch('/fillings/:name',adminAuth,fillings.patch);
router.delete('/fillings/:name',adminAuth,fillings.remove);


// Services' handlers (need to add filters for this section)
router.get('/services', services.getAll);
router.get('/services/:name', services.get);
router.put('/services',adminAuth,services.put);
router.patch('/services/:name',adminAuth,services.patch);
router.delete('/services/:name',adminAuth,services.remove);

// Reviews' handlers (we need to add filters to this section)
router.get('/reviews', reviews.getAll);
router.get('/reviews/:name', reviews.get);
router.put('/reviews',adminAuth,reviews.put);
router.patch('/reviews/:name',adminAuth,reviews.patch);
router.delete('/reviews/:name',adminAuth,reviews.remove);



// Leaderboard handler
router.get('/leaderboard', leaderboard.getAll);

module.exports = router;
