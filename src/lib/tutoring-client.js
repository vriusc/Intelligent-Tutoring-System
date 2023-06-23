import axios from 'axios'

export const baseURL = 'http://localhost:8080'

export const loginStudent = async (loginForm) => {
  return await axios.post(`${baseURL}/studentUser/login`, loginForm)
}

export const getStudent = async (studentId) => {
  return await axios.get(`${baseURL}/studentUser/${studentId}`)
}
