import axios from 'axios'

export const baseURL = 'http://tomato.vprofile.tomatokillerucd.com/gpt/reply/'

export const gptResponse = async (params) => {
  return await axios.post(baseURL, params)
}
