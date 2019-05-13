#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <utfilemgr.h>

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);
    app.setOrganizationName("me.lduboeuf.hw3");
    app.setApplicationName("hw3"); //not needed ?




    QQmlApplicationEngine engine;
    //QQmlContext *context = new QQmlContext(engine.rootContext());
#ifdef Q_OS_UBUNTU_TOUCH
    UTFileMgr fileManager;
    engine.rootContext()->setContextProperty("UBUNTU_TOUCH", true);
    engine.rootContext()->setContextProperty("utFileManager", &fileManager);
#endif
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
