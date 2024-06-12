const express = require("express");
const bodyParser = require("body-parser")
const UserRoute = require("./routers/user.route");
const adverRoute = require("./routers/adver.route");
const courseRoute = require("./routers/course.route");
const playlistRoute = require("./routers/playlist.route");
const communityRoute = require("./routers/community.route");
const startedRoute = require("./routers/started.route");
const quizRoute = require("./routers/quiz.route");
const jobRoute = require("./routers/job.router");
const jobappliedRoute = require("./routers/jobapplied.route");
const faqsRoute = require("./routers/faqs.route");
const classRoute = require("./routers/class.route");
const requestRoute = require("./routers/request.route");

const app = express();
app.use(bodyParser.json());
app.use("/",UserRoute);
app.use("/",adverRoute);
app.use("/",courseRoute);
app.use("/",playlistRoute);
app.use("/",communityRoute);
app.use("/",startedRoute);
app.use("/",quizRoute);
app.use("/",jobRoute);
app.use("/",jobappliedRoute);
app.use("/",faqsRoute);
app.use("/",classRoute);
app.use("/",requestRoute);

module.exports = app;
