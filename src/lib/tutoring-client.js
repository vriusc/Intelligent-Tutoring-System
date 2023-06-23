import axios from 'axios'

export const baseURL = 'http://localhost:8080'

export const loginUser = async (loginForm) => {
  console.log('Login...', loginForm)
  return await axios.post(`${baseURL}/myLogin`, loginForm)
  // return await axios.post(`${baseURL}/myLogin`, loginForm, {
  //   headers: { 'Access-Control-Allow-Origin': '*' }
  // })
}
