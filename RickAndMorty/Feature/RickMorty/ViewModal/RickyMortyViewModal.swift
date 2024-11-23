//
//  RickyMortyViewModal.swift
//  RickAndMorty
//
//  Created by samet on 23.11.2024.
//

import Foundation

protocol RickyMortyViewModalProtocol {
    func getItem()
    func loadingState()
    
    var rickyMortyCharacters:[Result] { get set }
    var rickMortyService:IRickyMortyService { get }
    var rickyMortyOutput: RickyMortyProtocol? { get }
    func setDelegate(output:RickyMortyProtocol)
    
}

final class RickyMortyViewModal: RickyMortyViewModalProtocol {
    var rickyMortyOutput: (any RickyMortyProtocol)?
    
    func setDelegate(output: any RickyMortyProtocol) {
        rickyMortyOutput = output
    }
    
    var rickyMortyCharacters: [Result] = []
    private var loading = false
    let rickMortyService: IRickyMortyService
    
    init() {
        self.rickMortyService = RickyAndMortyService()
    }
    
    func getItem() {
        loadingState()
        rickMortyService.getAllDatas { [weak self] (response)  in
            self?.loadingState()
            self?.rickyMortyCharacters = response ?? []
            self?.rickyMortyOutput?.saveDatas(values: self?.rickyMortyCharacters ?? [])
        }
    }
    
    func loadingState() {
        loading = !loading
        rickyMortyOutput?.changeLoading(load: loading)
    }
    

    
    
}
