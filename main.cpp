#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QFontDatabase>

QString loadFont(){
    int fontId = QFontDatabase::addApplicationFont(
                QCoreApplication::applicationDirPath() + "sarasa-mono-sc-regular.ttf");
    if(fontId == -1)
        return "Microsoft Yahei";
    return QFontDatabase::applicationFontFamilies(fontId).at(0);
}

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    QFont font(loadFont());

    QGuiApplication::setFont(font);

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
