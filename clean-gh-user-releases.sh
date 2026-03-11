# Lista as releases antigas do usuário em tela
function list_old_user_releases(){
    if [[ "$1" ]]; then
        for repo in $(gh repo list $1 --limit 1000 --json nameWithOwner -q '.[].nameWithOwner'); do
            gh release list -R "$repo" --limit 1000 --json tagName,publishedAt \
            | jq -r 'sort_by(.publishedAt) | reverse | .[3:] | .[].tagName' \
            | while read tag; do
                echo "Release: $repo - $tag"
            done
        done
    else
        echo "É necessário fornecer o username como parâmetro"
    fi
}

# Lista todas as releases do usuário em tela
function list_all_user_releases(){
    if [[ "$1" ]]; then
        for repo in $(gh repo list $1 --limit 1000 --json nameWithOwner -q '.[].nameWithOwner'); do
            gh release list -R "$repo" --limit 1000 --json tagName,publishedAt \
            | jq -r 'sort_by(.publishedAt) | reverse | .[].tagName' \
            | while read tag; do
                echo "Release: $repo - $tag"
            done
        done
    else
        echo "É necessário fornecer o username como parâmetro"
    fi
}


#Deleta as releases antigas do usuário - Utilize com cautela
function delete_old_user_releases(){
    if [[ "$1" ]]; then
        for repo in $(gh repo list $1 --limit 1000 --json nameWithOwner -q '.[].nameWithOwner'); do
            gh release list -R "$repo" --limit 1000 --json tagName,publishedAt \
            | jq -r 'sort_by(.publishedAt) | reverse | .[3:] | .[].tagName' \
            | while read tag; do
                echo "  Deletando release $repo - $tag"
                gh release delete "$tag" -R "$repo" --yes
            done
        done
    else
        echo "É necessário fornecer o username como parâmetro"
    fi
}