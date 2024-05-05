//
//  PDFViewer.swift
//  Medivise
//
//  Created by Sara Ortiz Drada on 29.04.24.
//

import SwiftUI
import PDFKit
import UIKit

struct PDFViewer: UIViewRepresentable {
    var url: URL
    @State private var document: PDFDocument?

    init(url: URL) {
        self.url = url
        self._document = State(initialValue: PDFDocument(url: url))
    }

    func makeUIView(context: Context) -> PDFView {
        let pdfView = PDFView()
        pdfView.document = document
        pdfView.autoScales = true

        let toolbar = makeToolbar(context: context)
        pdfView.addSubview(toolbar)

        toolbar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            toolbar.topAnchor.constraint(equalTo: pdfView.topAnchor),
            toolbar.leadingAnchor.constraint(equalTo: pdfView.leadingAnchor),
            toolbar.trailingAnchor.constraint(equalTo: pdfView.trailingAnchor),
            toolbar.heightAnchor.constraint(equalToConstant: 44)
        ])
        return pdfView
    }

    func updateUIView(_ pdfView: PDFView, context: Context) {
        self.document = PDFDocument(url: self.url)
        pdfView.document = self.document
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject {
        var parent: PDFViewer

        init(_ parent: PDFViewer) {
            self.parent = parent
        }
        @objc func downloadPDF() {
            guard let document = parent.document, let data = document.dataRepresentation() else { return }

            let activityViewController = UIActivityViewController(activityItems: [data], applicationActivities: nil)

            DispatchQueue.main.async {
                guard let rootViewController = UIApplication.shared.topMostViewController else { return }

                if let popoverController = activityViewController.popoverPresentationController {
                    popoverController.sourceView = rootViewController.view
                    popoverController.sourceRect = CGRect(x: rootViewController.view.bounds.midX, y: rootViewController.view.bounds.midY, width: 0, height: 0)
                    popoverController.permittedArrowDirections = []
                }
                rootViewController.present(activityViewController, animated: true, completion: nil)
            }
        }
    }

    func makeToolbar(context: Context) -> UIToolbar {
        let toolbar = UIToolbar()
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let downloadButton = UIBarButtonItem(barButtonSystemItem: .save, target: context.coordinator, action: #selector(Coordinator.downloadPDF))
        toolbar.setItems([flexSpace, downloadButton, flexSpace], animated: true)
        return toolbar
    }
}

extension UIViewController {
    func topMostViewController() -> UIViewController {
        if let presented = self.presentedViewController {
            return presented.topMostViewController()
        }
        if let navigation = self as? UINavigationController {
            return navigation.visibleViewController?.topMostViewController() ?? navigation
        }
        if let tab = self as? UITabBarController {
            return tab.selectedViewController?.topMostViewController() ?? tab
        }
        return self
    }
}

extension UIApplication {
    var topMostViewController: UIViewController? {
        return self.windows.filter{$0.isKeyWindow}.first?.rootViewController?.topMostViewController()
    }
}
