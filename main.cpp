#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QIcon>
#include <QQmlContext>
#include "droidstar.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    app.setOrganizationName("Die N8schicht");
    app.setOrganizationDomain("die-n8schicht.de");
    app.setApplicationName("N8DMR");
    app.setWindowIcon(QIcon(":/assets/n8schicht-icon.png"));
    qmlRegisterType<DroidStar>("org.die.n8schicht.n8dmr", 1, 0, "DroidStar");
    QQmlApplicationEngine engine;
#ifdef USE_FLITE
    engine.rootContext()->setContextProperty("USE_FLITE", QVariant(true));
#else
    engine.rootContext()->setContextProperty("USE_FLITE", QVariant(false));
#endif

    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.loadFromModule("N8DMRApp", "Main");
    return app.exec();

}
