export function uniqueID(email) {
    const now = new Date().getTime()

    const emailAcortado = email.slice(0, email.indexOf('@'))
    const hash = `${now}-${emailAcortado}`

    return hash
}