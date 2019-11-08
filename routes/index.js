var express = require("express");
var router = express.Router();
const fs = require("fs");
const dinoContent = fs.readFileSync("./dinosaurs.json");
const jsonContent = JSON.parse(dinoContent);

/* GET home page. */
router.get("/", function(req, res, next) {
  res.render("index", { title: "Dinosaur API" });
});

router.get("/dinosaurs", function(req, res, next) {
  res.json(jsonContent);
});

router.get("/dinosaurs/random", function(req, res, next) {
  let randomIndex = getRandomInt(jsonContent.length);
  res.json(jsonContent[randomIndex]);
});

router.get("/dinosaurs/random/name", function(req, res, next) {
  let randomIndex = getRandomInt(jsonContent.length);
  let json = { Name: jsonContent[randomIndex].Name };
  res.json(json);
});

router.get("/dinosaurs/random/description", function(req, res, next) {
  let randomIndex = getRandomInt(jsonContent.length);
  let json = { Description: jsonContent[randomIndex].Description };
  res.json(json);
});

function getRandomInt(max) {
  return Math.floor(Math.random() * Math.floor(max));
}

module.exports = router;
