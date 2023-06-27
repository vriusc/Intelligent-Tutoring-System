import axios from 'axios'

export const baseURL = '/gpt/reply/'

export const gptResponse = async (params) => {
  return await axios.post(baseURL, { params })
}
