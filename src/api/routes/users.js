import { Router } from 'express'
import controller from "../../controllers/users/index.js"
const router = Router()

router
    .get("/", controller.getAllUsers)
    .get("/:name", controller.getOneUser)
    .post("/", controller.createUser)
    .put("/:id", controller.updateUser)
    .put("/:id/active", controller.activeUser)
    .put("/:id/deactive", controller.deactiveUser)