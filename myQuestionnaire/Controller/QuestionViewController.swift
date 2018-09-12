//
//  QuestionViewController.swift
//  myQuestionnaire
//
//  Created by Gennadiy Glotov on 08.09.2018.
//  Copyright © 2018 Gennadiy Glotov. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {
    
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var singleStackView: UIStackView!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    
    @IBOutlet weak var multipleStackView: UIStackView!
    @IBOutlet weak var multiLabel1: UILabel!
    @IBOutlet weak var multiLabel2: UILabel!
    @IBOutlet weak var multiLabel3: UILabel!
    @IBOutlet weak var multiLabel4: UILabel!
    @IBOutlet weak var multiSwitch1: UISwitch!
    @IBOutlet weak var multiSwitch2: UISwitch!
    @IBOutlet weak var multiSwitch3: UISwitch!
    @IBOutlet weak var multiSwitch4: UISwitch!
    
    @IBOutlet weak var rangedStackView: UIStackView!
    @IBOutlet weak var rangedLabel1: UILabel!
    @IBOutlet weak var rangedLabel2: UILabel!
    @IBOutlet weak var rangedSlider: UISlider!
    
    @IBOutlet weak var questionProgressView: UIProgressView!
    
    @IBAction func singleAnswerButtonPressed(_ sender: UIButton) {
        let currentAnswers = questions[questionIndex].answers
        
        switch sender {
        case button1:
            answersChosen.append(currentAnswers[0])
        case button2:
            answersChosen.append(currentAnswers[1])
        case button3:
            answersChosen.append(currentAnswers[2])
        case button4:
            answersChosen.append(currentAnswers[3])
        default:
            break
        }
        
        nextQuestion()
    }
    
    @IBAction func multipleAnswerButtonPressed() {
        let currentAnswers = questions[questionIndex].answers
        
        if multiSwitch1.isOn {
            answersChosen.append(currentAnswers[0])
        }
        if multiSwitch2.isOn {
            answersChosen.append(currentAnswers[1])
        }
        if multiSwitch3.isOn {
            answersChosen.append(currentAnswers[2])
        }
        if multiSwitch4.isOn {
            answersChosen.append(currentAnswers[3])
        }
        
        nextQuestion()
    }
    
    @IBAction func rangedAnswerButtonPressed() {
        let currentAnswers = questions[questionIndex].answers
        
        let index = Int(round(rangedSlider.value * Float(currentAnswers.count - 1)))
        answersChosen.append(currentAnswers[index])
        
        nextQuestion()
    }
    
    var questions: [Question] = [
        Question(text: "Какая есть закуска?",
                 type: .single,
                 answers: [
                    Answer(text: "холодильник пуст", type: .coctale),
                    Answer(text: "креветки", type: .beer),
                    Answer(text: "рыба", type: .vine),
                    Answer(text: "шашлычок", type: .vodka)
            ]),
        Question(text: "Из кого состоит компания?",
                 type: .multiple,
                 answers: [
                    Answer(text: "одни девушки", type: .coctale),
                    Answer(text: "одни парни", type: .beer),
                    Answer(text: "50 на 50", type: .vine),
                    Answer(text: "да без разницы, просто хороший повод", type: .vodka)
            ]),
        Question(text: "Какой градус предпочитаете пить?",
                 type: .ranged,
                 answers: [
                    Answer(text: "чем меньше, тем лучше", type: .beer),
                    Answer(text: "ну так", type: .vine),
                    Answer(text: "крепкое, но что-то одно", type: .vodka),
                    Answer(text: "люблю смешивать и смотреть что их этого выйдет", type: .coctale)
            ])
    ]

    var questionIndex = 0
    
    var answersChosen: [Answer] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    

    func updateUI(){
        singleStackView.isHidden = true
        multipleStackView.isHidden = true
        rangedStackView.isHidden = true
        
        navigationItem.title = "Вопрос №\(questionIndex + 1)"
        
        let currentQuestion = questions[questionIndex]
        let currentAnswers = currentQuestion.answers
        let totalProgress = Float(questionIndex) / Float(questions.count)
        
        questionLabel.text = currentQuestion.text
        questionProgressView.setProgress(totalProgress, animated: true)
        
        switch currentQuestion.type {
        case .single:
            updateSingleStack(using: currentAnswers)
        case .multiple:
            updateMultipleStack(using: currentAnswers)
        case .ranged:
            updateRangedStack(using: currentAnswers)
        }
    }
    
    func updateSingleStack(using answer: [Answer]){
        singleStackView.isHidden = false
        button1.setTitle(answer[0].text, for: .normal)
        button2.setTitle(answer[1].text, for: .normal)
        button3.setTitle(answer[2].text, for: .normal)
        button4.setTitle(answer[3].text, for: .normal)
    }
    
    func updateMultipleStack(using answer: [Answer]){
        multipleStackView.isHidden = false
        multiSwitch1.isOn = false
        multiSwitch2.isOn = false
        multiSwitch3.isOn = false
        multiSwitch4.isOn = false
        multiLabel1.text = answer[0].text
        multiLabel2.text = answer[1].text
        multiLabel3.text = answer[2].text
        multiLabel4.text = answer[3].text
    }
    
    func updateRangedStack(using answer: [Answer]){
        rangedStackView.isHidden = false
        rangedSlider.setValue(0.5, animated: true)
        rangedLabel1.text = answer.first?.text
        rangedLabel2.text = answer.last?.text
    }

    func nextQuestion() {
        questionIndex += 1
        
        if questionIndex < questions.count {
            updateUI()
        } else {
            performSegue(withIdentifier: "ToResultView", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToResultView" {
            let resultsViewController = segue.destination as! ResultViewController
            resultsViewController.responces = answersChosen
            questionIndex = 0
            answersChosen = []
            updateUI()
        }
    }
    
}
