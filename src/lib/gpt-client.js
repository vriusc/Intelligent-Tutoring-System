import axios from 'axios'

// export const baseURL = 'http://tomato.vprofile.tomatokillerucd.com/gpt/reply/'
export const baseURL = '/gpt'

export const postGPTFeedback = async (params) => {
  return await axios.post(`${baseURL}/feedback`, params, { params })
}

export const postGPTEssay = async (params) => {
  return await axios.post(`${baseURL}/writing`, params, { params })
}

// export const gptResponse = async (params) => {
//   return await axios.post(baseURL, params)
// }
