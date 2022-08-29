import { PrismaClient } from '@prisma/client'
const prisma = new PrismaClient()

async function getAllUsers() {
    const users = await prisma.user.findMany()
    return users
}

async function getOneUser(name) {
    const user = await prisma.user.findOne({
        where: {
            name: name
        }
    })
}

async function createUser(data) {
    const createdUser = await prisma.user.create({
        data: data
    })
    return createdUser
}   

async function updateUser(id, data) {
    const updatedUser = await prisma.user.updateOne({
        where: {
            id: id
        },
        data: data
    })
    return updatedUser
}

async function activeUser(id) {
    const activeUser = await prisma.user.updateOne({
        where: {
            id: id
        },
        data: {
            active: true
        }
    })
    return activeUser
}

async function deactiveUser(id) {
    const deactiveUser = await prisma.user.updateOne({
        where: {
            id: id
        },
        data: {
            active: false
        }
    })
    return deactiveUser
}


