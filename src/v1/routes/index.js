import { Router } from 'express'

const router = Router()

router
    .get("/", (req, res) => {
        res.send("Bienvenido a TinderJob")
    })
    .get("/profile")
    .get("/timeline")
    .get("/settings")