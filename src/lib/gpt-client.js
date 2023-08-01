import axios from 'axios'

// export const baseURL = 'http://tomato.vprofile.tomatokillerucd.com/gpt/reply/'
// export const baseURL = 'http://localhost:8082/api'
export const baseURL = '/gpt'


export const postGPTFeedback = async (data) => {
  return await axios.post(`${baseURL}/feedback`, data)
}

export const postGPTEssay = async (data) => {
  return await axios.post(`${baseURL}/writting`, data)
}

// export const gptResponse = async (params) => {
//   return await axios.post(baseURL, params)
// }
