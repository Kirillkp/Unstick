//
//  MockAppSelectionCatalogService.swift
//  Unstick
//
//  Created by Codex on 13.04.2026.
//

import Foundation

/// Mock-каталог приложений/категорий для AppSelection.
final class MockAppSelectionCatalogService: IAppSelectionCatalogService {
    private let catalog: [AppSelectionCatalogCategory]

    init(catalog: [AppSelectionCatalogCategory] = MockAppSelectionCatalogService.defaultCatalog()) {
        self.catalog = catalog
    }

    func fetchCatalog() async throws -> [AppSelectionCatalogCategory] {
        catalog
    }
}

private extension MockAppSelectionCatalogService {
    static func defaultCatalog() -> [AppSelectionCatalogCategory] {
        [
            .init(
                id: UUID(uuidString: "A81B9E5B-EC4D-430A-A662-6DBA91CD2A12") ?? UUID(),
                title: "Соцсети",
                iconSystemName: "point.3.connected.trianglepath.dotted",
                apps: [
                    .init(
                        id: UUID(uuidString: "E4F0E6B0-545A-4F24-B08A-EAFA5E0E4201") ?? UUID(),
                        title: "Instagram",
                        iconSystemName: "camera.macro"
                    ),
                    .init(
                        id: UUID(uuidString: "9D3A1E59-2A79-4BF3-8995-9A1E2116C261") ?? UUID(),
                        title: "TikTok",
                        iconSystemName: "music.note"
                    ),
                    .init(
                        id: UUID(uuidString: "5E1F616B-416E-4E40-973F-1FC4B91A830F") ?? UUID(),
                        title: "Twitter",
                        iconSystemName: "bubble.left.and.bubble.right"
                    )
                ]
            ),
            .init(
                id: UUID(uuidString: "E4BDF9B5-A6E8-4EB1-906B-BE131702E7F1") ?? UUID(),
                title: "Видео",
                iconSystemName: "movieclapper",
                apps: [
                    .init(
                        id: UUID(uuidString: "7E36E961-14F5-4B3E-98DD-228A8DB39F01") ?? UUID(),
                        title: "YouTube",
                        iconSystemName: "play.rectangle.fill"
                    ),
                    .init(
                        id: UUID(uuidString: "F8B8C159-B0A1-4D6A-964B-4F17AD4CB9D2") ?? UUID(),
                        title: "Netflix",
                        iconSystemName: "tv.fill"
                    ),
                    .init(
                        id: UUID(uuidString: "0B6AF81C-D6D1-42C3-B5CF-77AE086672B8") ?? UUID(),
                        title: "Twitch",
                        iconSystemName: "play.tv.fill"
                    )
                ]
            ),
            .init(
                id: UUID(uuidString: "4E5D7515-362C-43FD-BF58-7AA16FB3D0D6") ?? UUID(),
                title: "Игры",
                iconSystemName: "gamecontroller",
                apps: [
                    .init(
                        id: UUID(uuidString: "A9C1F87A-1988-45E1-A9F6-4A559DE644E4") ?? UUID(),
                        title: "Mobile Legends",
                        iconSystemName: "gamecontroller.fill"
                    ),
                    .init(
                        id: UUID(uuidString: "6C1A48CB-2789-4662-BD80-C2115C70F0B7") ?? UUID(),
                        title: "Rise of Kingdoms",
                        iconSystemName: "shield.lefthalf.filled"
                    ),
                    .init(
                        id: UUID(uuidString: "D8F8E6F4-26D7-4D88-8A0A-304D2983C722") ?? UUID(),
                        title: "Royal Match",
                        iconSystemName: "dice.fill"
                    )
                ]
            )
        ]
    }
}
