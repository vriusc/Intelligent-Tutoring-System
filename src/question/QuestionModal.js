import './Question.css'
import {
  Button,
  Card,
  CardBody,
  CardText,
  CardTitle,
  Input,
  Modal,
  ModalBody,
  ModalFooter,
  ModalHeader
} from 'reactstrap'
import { useEffect, useState } from 'react'
import { getAllSubjects } from '../lib/tutoring-client'
import { postGPTQuestion } from '../lib/gpt-client'

const GPTQuestionModal = (args) => {
  const { isOpen, setGPTModal, question, questModal, subjectId } = args

  const [questionData, setQuestionData] = useState({})
  const [subject, setSubject] = useState({})
  const [loading, setLoading] = useState(false)
  const [gptText, setGPTText] = useState('')
  const [gptError, setGPTError] = useState(false)

  useEffect(() => {
    getAllSubjects({ subjectId }).then((response) => {
      const { content } = response.data
      if (content && content.length > 0) {
        setSubject(content[0])
      }
    })
  }, [])

  const searchGPT = () => {
    const { questionId, description } = question
    const data = {
      ...questionData,
      ...questModal,
      subject: subject.subjectName,
      question: questionId.toString(),
      question_description: description || ''
    }
    console.log('Data to send', data)
    setLoading(true)
    setGPTError(false)
    postGPTQuestion(data)
      .then((response) => {
        setGPTText(response.data)
        setLoading(false)
      })
      .catch((error) => {
        console.error(error)
        setLoading(false)
        setGPTError(true)
      })
  }

  return (
    <Modal isOpen={isOpen} size="lg" centered>
      <ModalHeader>Welcome! to ITS Buddy</ModalHeader>
      <ModalBody>
        <h6>{`Ask anything related to the question:  ${question.question}`}</h6>
        <div className="Quest-modal-gpt">
          <Input
            style={{ flex: 1, marginRight: '5px' }}
            name="student_question"
            type="textarea"
            placeholder="Add your question here."
            value={questionData.student_question}
            disabled={loading}
            rows={10}
            onChange={(e) => setQuestionData({ ...questionData, student_question: e.target.value })}
          />
          <Card style={{ flex: 1, marginLeft: '5px' }} color="light">
            <CardBody>
              <CardTitle tag="h5">Response:</CardTitle>
              {loading && <CardText>Loading response...</CardText>}
              {!loading && gptText && <CardText>{gptText}</CardText>}
              {!loading && gptError && (
                <CardText>Something went wrong with the consultation</CardText>
              )}
            </CardBody>
          </Card>
        </div>
      </ModalBody>
      <ModalFooter>
        <div className="Modal-bottom" style={{ justifyContent: 'space-evenly' }}>
          <Button
            disabled={
              loading || !questionData.student_question || questionData.student_question === ''
            }
            onClick={() => searchGPT()}
          >
            Send
          </Button>
          <Button color="danger" disabled={loading} onClick={() => setGPTModal(false)}>
            Back
          </Button>
        </div>
      </ModalFooter>
    </Modal>
  )
}

export default GPTQuestionModal
