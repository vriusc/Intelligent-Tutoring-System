import { Input } from 'reactstrap'
import { useTranslation } from 'react-i18next'

const LanguageSelector = () => {
  const { i18n } = useTranslation()
  const optionsList = [
    { value: 'en', text: 'English' },
    { value: 'es', text: 'Español' },
    { value: 'zh', text: '国语 [國語] ' },
    { value: 'fr', text: 'Français' },
    { value: 'it', text: 'Italiano' }
  ]

  const handleLanguage = (event) => {
    const { value } = event.target
    i18n.changeLanguage(value)
  }

  return (
    <Input type="select" value={i18n.language} onChange={handleLanguage}>
      {optionsList.map((opt, index) => (
        <option key={index} value={opt.value}>
          {opt.text}
        </option>
      ))}
    </Input>
  )
}

export default LanguageSelector
