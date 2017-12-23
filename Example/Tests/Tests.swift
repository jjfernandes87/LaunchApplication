import XCTest
import LaunchApplication

class Tests: XCTestCase {
    
    let mock = MockSequence()
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    /// Garantimos que a assinatura de protocol esta correta
    func testDelegateNotNill() {
        mock.launchWithDelegate(delegate: self)
        XCTAssertNotNil(mock.getDelegate())
    }
    
    /// Testamos o metodo nextLaunchStage para passar entre os passo de inicialização
    func testNextLaunchStage() {
        mock.launchAndRelaunchSequence()
        mock.nextLaunchStage()
        XCTAssertEqual(mock.getLaunchSequenceStage(), 1)
    }
    
    func testSequenceDone() {
        mock.launchAndRelaunchSequence()
        mock.nextLaunchStage()
        mock.nextLaunchStage()
        XCTAssertEqual(mock.getLaunchSequenceStage(), 2)
    }
    
    /// Testamos que a quantidade de itens adicionando na launchSequence esta correto
    func testLaunchSequenceCount() {
        mock.launchAndRelaunchSequence()
        XCTAssertEqual(mock.launchSequence.count, 2)
    }
    
    /// Testamos que a quantidade de itens adicionando na relaunchSequence esta correto
    func testRelaunchSequenceCount() {
        mock.launchAndRelaunchSequence()
        XCTAssertEqual(mock.relaunchSequence.count, 2)
    }
    
    /// Testamos que carregando launchAndRelaunchSequence e launchWithError continua como false
    func testLaunchSequenceSuccess() {
        mock.launchAndRelaunchSequence()
        XCTAssertEqual(mock.launchWithError, false)
    }
    
    /// Testamos que carregando launchAndRelaunchSequence e uma passo seja executado e tenha erro, o launchWithError seja true
    func testLaunchSequenceFail() {
        mock.launchAndRelaunchSequenceFail()
        mock.boot3()
        XCTAssertEqual(mock.launchWithError, true)
    }
}

extension Tests: LaunchApplicationProtocol {
    func didFinishLaunchSequence(application: LaunchApplication) {
        
    }
}

class MockSequence: LaunchApplication {
    
    /// Metodo responsável por carregar a lista de launch e relaunch
    @objc func launchAndRelaunchSequence() {
        launchSequence.append("LaunchStage_boot1")
        launchSequence.append("LaunchStage_boot2")
        
        relaunchSequence.append("LaunchStage_boot1")
        relaunchSequence.append("LaunchStage_boot2")
    }
    
    /// Metodo responsável por carregar a lista de launch e relaunch
    @objc func launchAndRelaunchSequenceFail() {
        launchSequence.append("LaunchStage_boot1")
        launchSequence.append("LaunchStage_boot2")
        launchSequence.append("LaunchStage_boot3")
        
        relaunchSequence.append("LaunchStage_boot1")
        relaunchSequence.append("LaunchStage_boot2")
        relaunchSequence.append("LaunchStage_boot3")
    }
    
    /// Metodo 1 para ser executado
    @objc func boot1() {
        print("boot1")
        nextLaunchStage()
    }
    
    /// Metodo 2 para ser executado
    @objc func boot2() {
        print("boot2")
        nextLaunchStage()
    }
    
    /// Metodo 2 para ser executado
    @objc func boot3() {
        print("boot3")
        launchWithError = true
        nextLaunchStage()
    }
}

