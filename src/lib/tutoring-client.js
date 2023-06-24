import axios from 'axios'

export const baseURL = 'http://localhost:8080'

export const loginStudent = async (loginForm) => {
  return await axios.post(`${baseURL}/studentUser/login`, loginForm)
}

export const registerStudent = async (studentForm) => {
  return await axios.post(`${baseURL}/studentUser/register`, studentForm)
}

export const updatePassword = async (updateStudentForm) => {
  return await axios.post(`${baseURL}/studentUser/password`, updateStudentForm)
}

export const getStudent = async (studentId) => {
  return await axios.get(`${baseURL}/studentUser/${studentId}`)
}

export const getAllSubjects = async (params) => {
  return await axios.get(`${baseURL}/subjects/queryAllSubjects`, { params })
}

export const getSubjectsById = async (studentId) => {
  return await axios.get(`${baseURL}/studentSubjects/queryByStudentId/${studentId}`)
}

export const addSubjectStudent = async (data) => {
  return await axios.post(`${baseURL}/studentSubjects/add`, data)
}
