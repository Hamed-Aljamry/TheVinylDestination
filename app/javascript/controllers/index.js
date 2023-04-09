// This file is auto-generated by ./bin/rails stimulus:manifest:update
// Run that command whenever you add a new controller or create them with
// ./bin/rails generate stimulus controllerName

import { application } from "./application"

import HelloController from "./hello_controller"
application.register("hello", HelloController)

import ModalController from "./modal_controller"
application.register("modal", ModalController)

import PlayController from "./play_controller"
application.register("play", PlayController)

import SearchController from "./search_controller"
application.register("search", SearchController)

import SeeMoreController from "./see_more_controller"
application.register("see-more", SeeMoreController)
