import jenkins.model.*
import com.cloudbees.plugins.credentials.*
import com.cloudbees.plugins.credentials.common.*
import com.cloudbees.plugins.credentials.domains.*
import com.cloudbees.plugins.credentials.impl.*
import com.cloudbees.jenkins.plugins.sshcredentials.impl.*
import hudson.plugins.sshslaves.*;

domain = Domain.global()
store = Jenkins.instance.getExtensionList('com.cloudbees.plugins.credentials.SystemCredentialsProvider')[0].getStore()
def credentials = []

credentials << new BasicSSHUserPrivateKey(
    CredentialsScope.GLOBAL,
    "jenkins",
    "jenkins",
    new BasicSSHUserPrivateKey.UsersPrivateKeySource(),
    "",
    ""
)
println('==> Adding credentials during jenkins initialization')

credentials.each { entry ->
    store.addCredentials(domain, entry)
}
