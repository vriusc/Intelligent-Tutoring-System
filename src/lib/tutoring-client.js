import axios from 'axios'

//export const baseURL = 'http://localhost:8080'

export const loginStudent = async (loginForm) => {
  return await axios.post(`/studentUser/login`, loginForm)
}

export const registerStudent = async (studentForm) => {
  return await axios.post(`/studentUser/register`, studentForm)
}

export const updatePassword = async (updateStudentForm) => {
  return await axios.post(`/studentUser/password`, updateStudentForm)
}

export const getStudent = async (studentId) => {
  return await axios.get(`/studentUser/${studentId}`)
}

export const getAllSubjects = async (params) => {
  return await axios.get(`/subjects/queryAllSubjects`, { params })
}

export const getSubjectsById = async (studentId) => {
  return await axios.get(`/studentSubjects/queryByStudentId/${studentId}`)
}
