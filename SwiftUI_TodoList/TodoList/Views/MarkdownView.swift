//
//  MarkdownView.swift
//  TodoList
//
//  Created by Dinesh Shaw on 20/11/24.
//

import SwiftUI
import Down

struct InlineMarkdownEditor: UIViewRepresentable {
    @Binding var text: String
    
    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.isEditable = true
        textView.isScrollEnabled = true
        textView.font = UIFont.systemFont(ofSize: 24)
        textView.delegate = context.coordinator
        return textView
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        // Preserve the cursor position
        let selectedRange = uiView.selectedRange
        uiView.attributedText = renderMarkdown(text)
        uiView.selectedRange = selectedRange
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    private func renderMarkdown(_ markdown: String) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: markdown)
        
        // Use Down library to style markdown if possible
        if let rendered = try? Down(markdownString: markdown).toAttributedString() {
            return rendered
        }
        
       
        let boldPattern = "\\*(.*?)\\*"          // *bold*
        let italicPattern = "\\_(.*?)\\_"        // _italic_
        
        // Apply bold style for `*bold*`
        applyStyle(to: attributedString, pattern: boldPattern, attributes: [.font: UIFont.boldSystemFont(ofSize: 24)])
        
        // Apply italic style for `_italic_`
        applyStyle(to: attributedString, pattern: italicPattern, attributes: [.font: UIFont.italicSystemFont(ofSize: 24)])
        return attributedString
    }
    
    private func applyStyle(to attributedString: NSMutableAttributedString, pattern: String, attributes: [NSAttributedString.Key: Any]) {
        let regex = try? NSRegularExpression(pattern: pattern, options: [])
        let range = NSRange(location: 0, length: attributedString.string.utf16.count)
        
        regex?.enumerateMatches(in: attributedString.string, options: [], range: range) { match, _, _ in
            if let matchRange = match?.range(at: 1) {
                attributedString.addAttributes(attributes, range: matchRange)
            }
        }
    }
    
    class Coordinator: NSObject, UITextViewDelegate {
        var parent: InlineMarkdownEditor
        var lastRenderedText: String = ""
        
        init(_ parent: InlineMarkdownEditor) {
            self.parent = parent
        }
        
        func textViewDidChange(_ textView: UITextView) {
            if textView.text != lastRenderedText {
                lastRenderedText = textView.text
                
                // Use DispatchQueue to avoid modifying state during view update
                DispatchQueue.main.async {
                    self.parent.text = textView.text
                }
            }
        }
    }

}

struct ContentView: View {
    @State private var markdownText: String = "Hello *SwiftUI*, _edit_ markdown *inline* while typing."
    
    var body: some View {
        VStack {
            InlineMarkdownEditor(text: $markdownText)
                .frame(height: 200)
                .border(Color.gray)
                .background(Color.secondary)
        }
        .padding()
    }
}


#Preview {
    ContentView()
}
