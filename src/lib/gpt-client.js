import axios from 'axios'

export const baseURL = 'http://tomato.vprofile.tomatokillerucd.com/gpt'
// export const baseURL = 'http://localhost:8082/api'

export const postGPTFeedback = async (params) => {
  return await axios.post(`${baseURL}/feedback`, params, { params })
}

export const postGPTEssay = async (params) => {
  return await axios.post(`${baseURL}/writing`, params, { params })
}

// export const gptResponse = async (params) => {
//   return await axios.post(baseURL, params)
// }
