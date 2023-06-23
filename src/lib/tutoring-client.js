import axios from 'axios'

export const baseURL = 'http://localhost:8080'

export const loginUser = async (loginForm) => {
  return await axios.post(`${baseURL}/studentUser/login`, loginForm)
}
