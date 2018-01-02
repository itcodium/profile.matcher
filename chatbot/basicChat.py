from chatterbot import ChatBot

chatbot = ChatBot(
    'Ron Obvious',
    trainer='chatterbot.trainers.ChatterBotCorpusTrainer'
)

# Train based on the english corpus
# chatbot.train("chatterbot.corpus.english")

# Get a response to an input statement
#res=chatbot.get_response("Security threats")
#res=chatbot.get_response("hello")
res=chatbot.get_response("give me a report")


print(res)