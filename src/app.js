import express from 'express'
import dotenv from 'dotenv'
import session from 'express-session'
import passport from 'passport'
import morgan from "morgan"
import cors from "cors"

const app = express()

// Inicializaciones
dotenv.config()
app.use(morgan('dev'))
app.use(cors())
app.use(express.json())
app.use(express.urlencoded({ extended: false }))

app.use(session({
    secret: process.env.SESSION_SECRET,
    resave: false,
    saveUninitialized: false
}))
app.use(passport.initialize())
app.use(passport.session())

export default app