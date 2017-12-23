public class LaunchApplication: NSObject {
    
    /// Variáveis privadas
    private var delegate: LaunchApplicationProtocol?
    private var launchSequenceStage = 0
    private var comingFromBackground = false
    
    /// Variáveis publicas
    public var launchSequence = [String]()
    public var relaunchSequence = [String]()
    public var launchWithError = false
    
    public override init() {
        super.init()
        preloadLaunchAndRelaunchSequence()
    }
    
    public func launchWithDelegate(delegate: LaunchApplicationProtocol) {
        self.delegate = delegate
        nextLaunchStage()
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
    
    /// Quando a sequencia de inicialização foi concluido
    private func launchSequenceDone() {
        guard let delegate = self.delegate else { return }
        if delegate.responds(to: #selector(LaunchApplicationProtocol.launchApplicationDidFinishLaunchSequence(application:))) {
            delegate.launchApplicationDidFinishLaunchSequence(application: self)
        }
    }
    
    /// PRELOAD Responsável por verificar se existe o metodo "launchAndRelaunchSequence" implementado na extension do launch dentro do app. Para adicionar items no launch e realunch da aplicação basta criar o metodo "launchAndRelaunchSequence"
    private func preloadLaunchAndRelaunchSequence() {
        let selector = NSSelectorFromString("launchAndRelaunchSequence")
        if self.responds(to: selector) {
            UIControl().sendAction(selector, to: self, for: nil)
        }
    }
}

//MARK: Protocol
@objc public protocol LaunchApplicationProtocol: NSObjectProtocol {
    func launchApplicationDidFinishLaunchSequence(application: LaunchApplication)
}
