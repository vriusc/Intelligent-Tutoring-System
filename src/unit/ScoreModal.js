import { Alert, Button, Modal, ModalBody, ModalFooter, ModalHeader } from 'reactstrap'
import { useEffect, useState } from 'react'
import { postStudentUnit, putStudentUnit } from '../lib/tutoring-client'
import { postGPTFeedback } from '../lib/gpt-client'
import { useTranslation } from 'react-i18next'

const ScoreModal = (args) => {
  const { score, isOpen, finished, studentUnit, setStudentUnit, onReset, onNext, feedback } = args
  /** TODO questionOptions is been remove becasue of no necesity of All question descripton and option */
  const { t, i18n } = useTranslation()

  const [loadingFeedback, setLoadingFeedback] = useState(true)
  const [gptFeedback, setGPTFeedback] = useState('')
  const [feedbackError, setFeedbackError] = useState(false)

  const subjectOptionsList = [
    { code: 'en', value: 'English', text: 'English' },
    { code: 'es', value: 'Spanish', text: 'Español' },
    { code: 'zh', value: 'Mandarin', text: '国语 [國語] ' },
    { code: 'fr', value: 'French', text: 'Français' },
    { code: 'it', value: 'Italian', text: 'Italiano' }
  ]

  useEffect(() => {
    if (isOpen) {
      if (!finished) {
        if (studentUnit.studentUnitId) {
          const { studentUnitId, isfinished } = studentUnit
          putStudentUnit({ studentUnitId, isfinished }).then(settingStudentUnit)
        } else {
          postStudentUnit(studentUnit).then(settingStudentUnit)
        }
      }
      // FEEDBACK
      setLoadingFeedback(true)
      setGPTFeedback('')
      const data = {
        ...feedback,
        test_score: score.toString(),
        user_prefer_language: getLanguage(i18n.language)
      }
      console.log('Feedback to send', data)
      postGPTFeedback(data)
        .then((response) => {
          setGPTFeedback(response.data)
          setLoadingFeedback(false)
          setFeedbackError(false)
        })
        .catch((error) => {
          console.error(error.message)
          setLoadingFeedback(false)
          setFeedbackError(true)
        })
    }
  }, [isOpen])

  const settingStudentUnit = (response) => {
    const { data } = response
    setStudentUnit(data)
  }

  const getLanguage = (code) => {
    const languageOpt = subjectOptionsList.find((opt) => opt.code === code)
    return languageOpt.value
  }

  // const settingQuestionText = () => {
  //   let questionsText = ''
  //   questionOptions.forEach((thisQuest) => {
  //     if (thisQuest.description) {
  //       questionsText += `${thisQuest.questionOrder}) ${thisQuest.description} `
  //     }
  //   })
  //   return questionsText
  // }
  // const settingOptionText = () => {
  //   let optionsQuestText = ''
  //   questionOptions.forEach((thisQuest) => {
  //     let optionsText = ''
  //     thisQuest.options.forEach((opts) => {
  //       if (opts.description) {
  //         optionsText += `${letter[opts.orderNumber > 0 ? opts.orderNumber - 1 : 0].code}) ${
  //           opts.description
  //         } `
  //       }
  //     })
  //     if (optionsText) {
  //       optionsQuestText += `${thisQuest.questionOrder}) ${optionsText} `
  //     }
  //   })
  //   return optionsQuestText
  // }

  return (
    <Modal isOpen={isOpen} size="lg" centered>
      <ModalHeader>{loadingFeedback ? 'Score' : `Score: ${score}`}</ModalHeader>
      <ModalBody>
        {score === 10 && !loadingFeedback && <Alert color="success">{t('congrats')}</Alert>}
        {loadingFeedback && <Alert color="dark">{t('loading_score')}</Alert>}
        {!loadingFeedback && gptFeedback && (
          <Alert color={score >= 8 ? 'light' : score >= 4 ? 'warning' : 'danger'}>
            {gptFeedback}
          </Alert>
        )}
        {!loadingFeedback && feedbackError && (
          <>
            <Alert color={score >= 8 ? 'light' : score >= 4 ? 'warning' : 'danger'}>
              {`Your score is ${score}`}
            </Alert>
            <Alert color="danger">${'no_feedback'}</Alert>
          </>
        )}
      </ModalBody>
      <ModalFooter>
        <div className="Modal-bottom">
          {loadingFeedback && (
            <Button color="info" disabled={true}>
              {t('loading')}
            </Button>
          )}
          {!loadingFeedback && studentUnit.isfinished === 1 && (
            <Button color="success" onClick={() => onNext()} disabled={loadingFeedback}>
              {t('next_unit')}
            </Button>
          )}
          {!loadingFeedback && studentUnit.isfinished !== 1 && (
            <Button color="warning" onClick={() => onReset()} disabled={loadingFeedback}>
              {t('try_again')}
            </Button>
          )}
        </div>
      </ModalFooter>
    </Modal>
  )
}

export default ScoreModal
