using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(naveedLab.Startup))]
namespace naveedLab
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
        }
    }
}
