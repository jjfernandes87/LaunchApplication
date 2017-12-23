import UIKit

open class LaunchApplication: NSObject {
    
    /// Variáveis privadas
    private var delegate: LaunchApplicationProtocol?
    private var launchSequenceStage = 0
    private var comingFromBackground = false
    
    /// Variáveis publicas
    public var launchSequence = [String]()
    public var relaunchSequence = [String]()
    public var launchWithError = false
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    public override init() {
        super.init()
        preloadLaunchAndRelaunchSequence()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(enterForeground),
                                               name: NSNotification.Name.UIApplicationWillEnterForeground,
                                               object: UIApplication.shared)
    }
    
    /// Assinatura de delegate para controle de erro e finalização
    ///
    /// - Parameter delegate: delegate
    public func launchWithDelegate(delegate: LaunchApplicationProtocol) {
        self.delegate = delegate
        nextLaunchStage()
    }
    
    /// Retorna o delegate
    ///
    /// - Returns: LaunchApplicationProtocol
    public func getDelegate() -> LaunchApplicationProtocol? {
        return delegate
    }
    
    /// Retorna o em qual passo a sequencia esta passando
    ///
    /// - Returns: numero do passo
    public func getLaunchSequenceStage() -> Int {
        return launchSequenceStage
    }
    
    /// Passa entre um passo e outro da inicialização
    public func nextLaunchStage() {
        var targetSequence = comingFromBackground ? relaunchSequence : launchSequence
        
        if targetSequence.count > launchSequenceStage {
            let nextStage = targetSequence[launchSequenceStage].replacingOccurrences(of: "LaunchStage_", with: "")
            let stageSelector = NSSelectorFromString(nextStage)
            
            launchSequenceStage += 1
            
            let control = UIControl()
            control.sendAction(stageSelector, to: self, for: nil)
        } else {
            launchSequenceDone()
        }
    }
    
    /// Responsável for notificar que a sequencia foi finalizada
    private func launchSequenceDone() {
        guard let delegate = self.delegate else { return }
        if delegate.responds(to: #selector(LaunchApplicationProtocol.didFinishLaunchSequence(application:))) {
            delegate.didFinishLaunchSequence(application: self)
        }
    }
    
    /// Responsável por verificar se existe o metodo "launchAndRelaunchSequence" e chamalá para carregar a sequencia e incialização ou atualização
    private func preloadLaunchAndRelaunchSequence() {
        let selector = NSSelectorFromString("launchAndRelaunchSequence")
        if self.responds(to: selector) {
            UIControl().sendAction(selector, to: self, for: nil)
        }
    }
    
    /// Quando voltamos de background alteramos a variavel comingFromBackground
    @objc private func enterForeground() {
        comingFromBackground = true
        launchWithError = false
        launchSequenceStage = 0
        nextLaunchStage()
    }
}

//MARK: Protocol
@objc public protocol LaunchApplicationProtocol: NSObjectProtocol {
    @objc func didFinishLaunchSequence(application: LaunchApplication)
}
