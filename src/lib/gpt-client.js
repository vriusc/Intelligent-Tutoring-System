import axios from 'axios'

// export const baseURL = 'http://tomato.vprofile.tomatokillerucd.com/gpt/reply/'
export const baseURL = 'http://localhost:8082/api'

export const postGPTFeedback = async (params) => {
  return await axios.post(`${baseURL}/feedback`, { params })
}

// export const gptResponse = async (params) => {
//   return await axios.post(baseURL, params)
// }
