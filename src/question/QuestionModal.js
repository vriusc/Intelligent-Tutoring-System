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
import { useTranslation } from 'react-i18next'

const GPTQuestionModal = (args) => {
  const { isOpen, setGPTModal, question, questModal, subjectId, options } = args
  const { t, i18n } = useTranslation()

  const [questionData, setQuestionData] = useState({})
  const [subject, setSubject] = useState({})
  const [loading, setLoading] = useState(false)
  const [gptText, setGPTText] = useState('')
  const [gptError, setGPTError] = useState(false)

  const subjectOptionsList = [
    { code: 'en', value: 'English', text: 'English' },
    { code: 'es', value: 'Spanish', text: 'Español' },
    { code: 'zh', value: 'Mandarin', text: '国语 [國語] ' },
    { code: 'fr', value: 'French', text: 'Français' },
    { code: 'it', value: 'Italian', text: 'Italiano' }
  ]
  const letter = [
    { code: 'A' },
    { code: 'B' },
    { code: 'C' },
    { code: 'D' },
    { code: 'E' },
    { code: 'F' },
    { code: 'G' }
  ]

  useEffect(() => {
    getAllSubjects({ subjectId }).then((response) => {
      const { content } = response.data
      if (content && content.length > 0) {
        setSubject(content[0])
      }
    })
  }, [])

  const getLanguage = (code) => {
    const languageOpt = subjectOptionsList.find((opt) => opt.code === code)
    return languageOpt.value
  }

  const getOptionsDesc = () => {
    let optionToSend = ''
    options.forEach((opt, index) => {
      optionToSend += `${letter[index].code}) '${opt.description || ''}' `
    })
    return optionToSend
  }

  const searchGPT = () => {
    const { question: quest, description } = question
    const data = {
      ...questionData,
      ...questModal,
      subject: subject.subjectName,
      question: quest,
      question_description: description || '',
      user_prefer_language: getLanguage(i18n.language),
      option_description: getOptionsDesc()
    }
    console.log('Question to send', data)
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
      <ModalHeader>{t('welcome_to_buddy')}</ModalHeader>
      <ModalBody>
        <h6>{`${t('ask_question')}:  ${question.question}`}</h6>
        <div className="Quest-modal-gpt">
          <Input
            style={{ flex: 1, marginRight: '5px' }}
            name="student_question"
            type="textarea"
            placeholder={t('question_placeholder')}
            value={questionData.student_question}
            disabled={loading}
            rows={10}
            onChange={(e) => setQuestionData({ ...questionData, student_question: e.target.value })}
          />
          <Card style={{ flex: 1, marginLeft: '5px' }} color="light">
            <CardBody>
              <CardTitle tag="h5">{`${t('response')}:`}</CardTitle>
              {loading && <CardText>{t('loading_response')}</CardText>}
              {!loading && gptText && <CardText>{gptText}</CardText>}
              {!loading && gptError && <CardText>{t('error_feedback')}</CardText>}
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
            {t('send')}
          </Button>
          <Button color="danger" disabled={loading} onClick={() => setGPTModal(false)}>
            {t('back')}
          </Button>
        </div>
      </ModalFooter>
    </Modal>
  )
}

export default GPTQuestionModal
