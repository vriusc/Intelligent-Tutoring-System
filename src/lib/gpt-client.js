import axios from 'axios'

// export const baseURL = 'http://a364101939e1e4c9fb080d08df4119cb-906c9105a3303ad2.elb.us-east-1.amazonaws.com/gpt'
export const baseURL = 'http://tomato.vprofile.tomatokillerucd.com/gpt'
// export const baseURL = 'http://localhost:8082/api'

export const postGPTFeedback = async (data) => {
  return await axios.post(`${baseURL}/feedback`, data)
}

export const postGPTEssay = async (data) => {
  return await axios.post(`${baseURL}/writting`, data)
}

export const postGPTQuestion = async (data) => {
  return await axios.post(`${baseURL}/question`, data)
}

// export const gptResponse = async (params) => {
//   return await axios.post(baseURL, params)
// }
