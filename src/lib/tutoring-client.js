import axios from 'axios'

//export const baseURL = 'http://localhost:8080'

export const loginStudent = async (loginForm) => {
  return await axios.post(`/api/studentUser/login`, loginForm)
}

export const registerStudent = async (studentForm) => {
  return await axios.post(`/api/studentUser/register`, studentForm)
}

export const updatePassword = async (updateStudentForm) => {
  return await axios.post(`/api/studentUser/password`, updateStudentForm)
}

export const getStudent = async (studentId) => {
  return await axios.get(`/api/studentUser/${studentId}`)
}

export const getAllSubjects = async (params) => {
  return await axios.get(`/api/subjects/queryAllSubjects`, { params })
}

export const getSubjectsById = async (studentId) => {
  return await axios.get(`/api/studentSubjects/queryByStudentId/${studentId}`)
}
