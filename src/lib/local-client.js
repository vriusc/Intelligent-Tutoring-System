import axios from 'axios'

export const getLearningQuestionnaire = async () => {
  const route = '/data/learningQuestionnaire.json'
  return await axios.get(route)
}
